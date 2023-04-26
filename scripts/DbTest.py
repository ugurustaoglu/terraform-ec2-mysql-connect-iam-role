import pymysql
import sys
import boto3
import os


class DbConnect:
    def __init__(self, endpoint, user, region, dbname, port=3306):
        self.ENDPOINT = endpoint
        self.PORT = port
        self.USER = user
        self.REGION = region
        self.DBNAME = dbname
        os.environ['LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN'] = '1'

    def test(self):
        print('DBHostname=%s, Port=%s, DBUsername=%s, Region=%s' % (self.ENDPOINT, self.PORT, self.USER, self.REGION))

    def connect(self):
        session = boto3.Session()
        client = session.client('rds',region_name=self.REGION)
        token = client.generate_db_auth_token(DBHostname=self.ENDPOINT, Port=self.PORT, DBUsername=self.USER,
                                              Region=self.REGION)

        try:
            print("host=%s, user=%s, passwd=%s, port=%s,database=%s" %(self.ENDPOINT,self.USER, token,self.PORT, self.DBNAME))
            conn = pymysql.connect(host=self.ENDPOINT, user=self.USER, passwd=token, port=int(self.PORT),
                                   database=self.DBNAME,
                                   ssl_ca="rds-ca-2019-root.pem")
            cur = conn.cursor()
            cur.execute("""SELECT now()""")
            query_results = cur.fetchall()
            print(query_results)
        except Exception as e:
            print("Database connection failed due to {}".format(e))
