# import libraries
import urllib3
from bs4 import BeautifulSoup
import requests

page = requests.get("https://bitso.com")

from bs4 import BeautifulSoup
soup = BeautifulSoup(page.content, 'html.parser')
precio = soup.find_all(class_="stat")[0].get_text().strip().replace("MXN", "").replace(",", "").replace("$", "")
precio2 =  float(precio)
print(precio2)