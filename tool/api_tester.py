import requests
import datetime
url_fmt = 'http://127.0.0.1:8080/api/%s/%s.json'
def signup():
    user = datetime.datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
    print user
    r = requests.post(url_fmt % ('member', 'signup'), {
        'name':user, 
        'email':user+'@codepongo.com',
        'password':'123456'
        }
    )
    print r.status_code
    print r.text

def login():
    pass
    request.post(url_fmt % ('member', 'login'), {
        
        }

if __name__ == '__main__':
    if sys.argv[1] == '--signup':
        signup()
    elif sys.argv[1] == '--login':
        user = sys.argv[2]
        password = sys.argv[3]
        login(user, password)
