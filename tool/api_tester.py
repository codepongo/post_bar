import requests
import datetime
import sys
import json
url_fmt = 'http://127.0.0.1:8080/api/%s.json'
s = requests.Session()
def signin():
    r = s.get(url_fmt % ('mission/signin'))
    result = ret(r)
    if result:
        money = json.loads(r.text)['info']
        print money
    else:
        print False
def signup(user = datetime.datetime.now().strftime('%Y-%m-%d_%H_%M_%S')):
    print user
    r = requests.post(url_fmt % ('member/signup'), {
        'name':user, 
        'email':user+'@codepongo.com',
        'password':'123456'
        }
    )
    print r.status_code,  r.text


def login(user, password):
    r = s.post(url_fmt % ('member/login'), {
        'name':user, 
        'password':password
        }
    )
    return ret(r)

def ret(r):
    if r.status_code != 200:
        print r.status_code
        return False
    if not json.loads(r.text)['ret']:
        print json.loads(r.text)['msg']
        return False
    return True

def logout():
    r = s.get(url_fmt % ('member/logout'))
    return ret(r)

if __name__ == '__main__':
    if sys.argv[1] == '--signup':
        signup('codepongo')
    elif sys.argv[1] == '--login':
        user = sys.argv[2]
        password = sys.argv[3]
        print 'login:', login(user, password)
        print 'signin:',
        signin()
        print 'logout:', logout()
