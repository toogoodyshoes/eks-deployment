from pymongo import MongoClient, ReturnDocument
from pymongo.cursor import Cursor


class MongoDBDataProvider:
    def __init__(self, host, port, database):
        self.client = MongoClient(host, port)
        self.database = self.client[database]

    def insert_document(self, collection_name, document):
        collection = self.database[collection_name]
        return collection.insert_one(document)

    def update_document(self, collection_name, query, update):
        collection = self.database[collection_name]
        return collection.find_one_and_update(query, update)

    def read_document(self, collection_name, query):
        collection = self.database[collection_name]
        return collection.find(query)

    def check_existing(self, collection_name, name):
        query = {"name": name}
        update = {"$inc": {"visits": 1}}
        result = self.database[collection_name].find_one_and_update(
            query,
            update,
            upsert=True,
            return_document=ReturnDocument.AFTER
        )
        return result

    def close_connection(self):
        self.client.close()
