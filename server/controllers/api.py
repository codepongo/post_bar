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

class json:
    def GET(self, method):
        web.header('Content-Type', 'application/json')
        return method
