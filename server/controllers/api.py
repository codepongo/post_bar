# -- coding: utf8 --
import web
session = web.config._session 
from models.post_model import *
from models.node_model import *
from models.user_model import *
from models.comment_model import *
from models.cat_model import *
from libraries.crumb import Crumb
from libraries.pagination import *
import json
import controllers
from controllers.user import *
from controllers.index import *
import random

class node:
    def GET(self, method):
        web.header('Content-Type', 'application/json')
        if method.lower() == 'show':
            cats_result = cat_model().get_all()
            cats = []
            for cat_result in cats_result:
                cat = {'cat':cat_result}
                node = node_model().get_all({'category_id':cat_result.id})
                cat['node'] = node
                cats.append(cat)
            return json.dumps(cats)

class topic:
    def GET(self, method):
        web.header('Content-Type', 'application/json')
        if method.lower() == 'lastest':
            r = recent()
            _, posts, __ = r._get()
            ret = []
            for p in posts:
                ret.append(p)
            return json.dumps(ret)

class member:
    def GET(self, method):
        web.header('Content-Type', 'application/json')
        try:
            m = getattr(controllers.user, method.lower())
        except:
            return json.dumps({'ret':False, 'msg', ''})
        if m:
            m()._get()
        return json.dumps({'ret':True})

    def POST(self, method):
        web.header('Content-Type', 'application/json')
        if method.lower() == 'signup':
            ret, msg = signup()._post()
            return json.dumps({'ret':ret, 'msg':msg})
        if method.lower() == 'login':
            ret, msg = login()._post()
            return json.dumps({'ret':ret, 'msg':msg})

class mission:
    def GET(self, method):
        if method.lower() == 'signin':
            if session.user_id is None:
                return json.dumps({'ret':False, 'msg':'未登录'})
            gain = random.randint(1, 100)
            money_type_id = 7#money_type_model().get_one({'name':'post'})['id']
            balance = user_model().update_money(session.user_id, gain)
            money_model().insert({'user_id':session.user_id, 'money_type_id':money_type_id, 'amount':gain, 'length':0, 'balance': balance, 'foreign_id':0})
            return json.dumps({'ret':True, 'info':{'account':balance, 'gain':gain}})
