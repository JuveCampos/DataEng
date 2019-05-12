#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 12 11:09:24 2019

@author: juve
"""

# Python code to illustrate Sending mail  
# to multiple users  
# from your Gmail account  
import smtplib 
  
# list of email_id to send the mail 
li = ["juve*****@gmail.com", "juve**.*****@cide.edu"] 
  
for i in range(len(li)): 
    s = smtplib.SMTP('smtp.gmail.com', 587) 
    s.starttls() 
    s.login("juve*****@gmail.com", "****password***") 
    message = "Correo de prueba"
    s.sendmail("juve*****@gmail.com", li[i], message) 
    s.quit() 
