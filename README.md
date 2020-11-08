<img src="./assets/icons/v2.jpg" width=50px > 

# DT 
### DataTracker  
A simple one-page flutter app to tell me how much data does my BSNL FTTH has left.


### Why 
So, that data can be used judiciosuly by us. (hopefully) 

### Working
- Send a GET request to BSNL FUP(Fair Usage Policy) URL and parse the response headers to acquire cookie. 
- Use the cookie to send a Post request to BSNL's fetch_user_quota end-point. This end-point gives back JSON with the required fields.

### URLs Involved
- http://172.30.139.25:9090/ssssportal1/fetchUserQuotaPM.do
- http://172.30.139.25:9090/ssssportal1/manualRedirection.do

### Images
<centre>
<img src="./screenshot/sample.jpg" height=500px>
<centre>
<hr>

> Note : These IP addresses are region dependent. Might not work in different areas. 