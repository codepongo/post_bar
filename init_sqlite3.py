#coding:utf8
import sqlite3

db = sqlite3.connect('post_bar.db')
with open('post_bar_init_sqlite.sql', 'rb') as f:
    sql = f.read()
    sql = sql.replace('''INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(1,'post_cost','20','发帖基础花费财富'),
	(2,'post_cost_add','1','帖子每增加100字符花费'),
	(3,'post_length','200','帖子基础字符'),
	(4,'comment_length','100','评论基础字符'),
	(5,'comment_cost','5','评论基础花费'),
	(6,'comment_cost_add','1','评论每增加100字花费'),
	(7,'thanks_cost','10','感谢花费');''',
'''INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(1,'post_cost','20','发帖基础花费财富');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(2,'post_cost_add','1','帖子每增加100字符花费');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(3,'post_length','200','帖子基础字符');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(4,'comment_length','100','评论基础字符');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(5,'comment_cost','5','评论基础花费');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(6,'comment_cost_add','1','评论每增加100字花费');
INSERT INTO `money_option` (`id`, `key`, `value`, `comment`)
VALUES
	(7,'thanks_cost','10','感谢花费');''').replace(
'''INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(1,'invite','邀请'),
	(2,'post','主题'),
	(3,'comment','评论'),
	(4,'post_thanks','感谢主题'),
	(5,'comment_thanks','感谢评论');''',
'''INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(1,'invite','邀请');
INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(2,'post','主题');
INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(3,'comment','评论');
INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(4,'post_thanks','感谢主题');
INSERT INTO `money_type` (`id`, `name`, `comment`)
VALUES
	(5,'comment_thanks','感谢评论');''').replace('''
INSERT INTO `notify_type` (`id`, `name`, `comment`)
VALUES
	(1,'comment','收到评论'),
	(2,'post_at','在帖子中提及'),
	(3,'comment_at','在回复中提及');
''',
'''
INSERT INTO `notify_type` (`id`, `name`, `comment`)
VALUES
	(1,'comment','收到评论');
INSERT INTO `notify_type` (`id`, `name`, `comment`)
VALUES
	(2,'post_at','在帖子中提及');
INSERT INTO `notify_type` (`id`, `name`, `comment`)
VALUES
	(3,'comment_at','在回复中提及');
''').replace('''
INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(1,'title','CodePongo BBS'),
	(2,'description','CodePongo 论坛'),
	(3,'cookie_expires','604800'),
	(4,'site_url','bbs.codepongo.com');''',
'''
INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(1,'title','CodePongo BBS');
INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(2,'description','CodePongo 论坛');
INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(3,'cookie_expires','604800');
INSERT INTO `site` (`id`, `key`, `value`)
VALUES
	(4,'site_url','bbs.codepongo.com');''')
    db.executescript(sql)
db.close()
