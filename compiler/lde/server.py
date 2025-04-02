import http.server
import socketserver
import subprocess
import json
import os
import sys

# Get the port and the terminal directory path from the C code (passed as command-line arguments)
if len(sys.argv) != 3:
    print("Usage: server.py <PORT> <TERMINAL_DIRECTORY_PATH>")
    sys.exit(1)

PORT = int(sys.argv[1])  # Port passed by the C code
terminal_directory = sys.argv[2]  # Directory path passed by the C code

# Get the absolute path of where the Python file (server.py) is located to find index.html
script_dir = os.path.dirname(os.path.realpath(__file__))
index_html_path = os.path.join(script_dir, 'index.html')

# Ensure the index.html file exists in the directory where the script is located
if not os.path.exists(index_html_path):
    print(f"Error: index.html not found in {script_dir}")
    sys.exit(1)

# Class to handle HTTP requests
class MyHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Serve the index.html file when the root URL ("/") is accessed
        if self.path == '/':
            self.path = '/index.html'
        return super().do_GET()

    def translate_path(self, path):
        """Override the translate_path method to serve files from the script's directory."""
        # Serve index.html from the absolute script location
        if path == '/index.html':
            return index_html_path
        # For other files, serve from the directory passed by the C code (terminal_directory)
        return os.path.join(terminal_directory, os.path.relpath(path, "/"))

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        
        if self.path == '/execute':
            # Execute the command provided in the POST data
            command = json.loads(post_data).get('command')
            if not command:
                self.send_error(400, "No command provided.")
                return

            try:
                # Run the command with the terminal_directory as the current working directory
                result = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, cwd=terminal_directory)
                result = result.decode('utf-8', errors='replace')
            except subprocess.CalledProcessError as e:
                result = e.output.decode('utf-8', errors='replace')

            # Return the command execution result
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"result": result}).encode('utf-8'))

        elif self.path == '/open':
            # Open a file in the terminal directory and return its content
            filename = json.loads(post_data).get('filename')
            if not filename:
                self.send_error(400, "No filename provided.")
                return

            filepath = os.path.join(terminal_directory, filename)

            if not os.path.isfile(filepath):
                self.send_response(404)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"success": False, "error": "File not found"}).encode('utf-8'))
                return
            
            try:
                with open(filepath, 'r') as file:
                    content = file.read()
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"success": True, "content": content}).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"success": False, "error": str(e)}).encode('utf-8'))

        elif self.path == '/save':
            # Save content to a file in the terminal directory
            data = json.loads(post_data)
            filename = data.get('filename')
            content = data.get('content')

            if not filename or not content:
                self.send_error(400, "Filename or content missing.")
                return

            filepath = os.path.join(terminal_directory, filename)

            try:
                with open(filepath, 'w') as file:
                    file.write(content)
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"success": True}).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.send_header('Content-type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({"success": False, "error": str(e)}).encode('utf-8'))

        else:
            self.send_error(404)


# Start the server, handle port binding errors
try:
    with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
        print(f"Serving on port {PORT}")
        httpd.serve_forever()
except OSError as e:
    print(f"Error: Port {PORT} is already in use.")
    sys.exit(1)