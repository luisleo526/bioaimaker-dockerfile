from jupyter_server.auth import passwd
import os

# Set options for ip, password, and toggle off browser auto-opening
c.ServerApp.ip = '*'
c.ServerApp.token = ''
c.ServerApp.open_browser = False
c.ServerApp.base_url = os.environ.get('BASE_URL', '/')
c.ServerApp.root_dir = os.environ.get('NOTEBOOK_FOLDER', '/root/notebooks')

password = os.environ.get('PASSWORD')
if password:
    c.ServerApp.password = passwd(password)
else:
    c.ServerApp.password = ''
