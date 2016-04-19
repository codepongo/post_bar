import requests
import datetime
import sys
url_fmt = 'http://127.0.0.1:8080/api/%s.json'
def signin():
def signup():
    user = datetime.datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
    print user
    r = requests.post(url_fmt % ('member/signup'), {
        'name':user, 
        'email':user+'@codepongo.com',
        'password':'123456'
        }
    )
    print r.status_code,  r.text

def login(user, password):
    r = requests.post(url_fmt % ('member/login'), {
        'name':user, 
        'password':password
        }
    )
    print r.status_code, r.text
    print r.cookies
def logout():
    r = requests.get(url_fmt % ('member/logout'))
    print r.status_code#, r.text

if __name__ == '__main__':
    if sys.argv[1] == '--signup':
        signup()
    elif sys.argv[1] == '--login':
        user = sys.argv[2]
        password = sys.argv[3]
        login(user, password)
        logout()
