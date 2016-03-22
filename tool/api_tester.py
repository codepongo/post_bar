import requests
import datetime
url_fmt = 'http://127.0.0.1:8080/api/%s.json'
def signup():
    user = datetime.datetime.now().strftime('%Y-%m-%d_%H_%M_%S')

    r = requests.post(url_fmt % ('signup'), {
        'name':user, 
        'email':user+'@codepongo.com',
        'password':'123456'
        }
    )
    print r.status_code
    print r.text

if __name__ == '__main__':
    signup()
