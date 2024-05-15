from mongo_data_provider import MongoDBDataProvider

DB_NAME = "visitors"
DB_COLLECTION = "visit_count"

client = MongoDBDataProvider("mongodb://mongo", 27017, DB_NAME)
