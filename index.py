from urllib import request, response, error, parse
from urllib.request import urlopen
from bs4 import BeautifulSoup
import os

page=open('bluetooth_content_share.html').read()
found=BeautifulSoup(page,"lxml")
body=found.body.get_text()

if(body=="camera"):
    os.system('cmd /k "start microsoft.windows.camera:"')