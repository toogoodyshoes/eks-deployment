from mongo_data_provider import MongoDBDataProvider

TEST_DB = "visitors"
TEST_COLLECTION = "count"

if __name__ == '__main__':

    # Instantiate the MongoDBDataProvider
    mongo_provider = MongoDBDataProvider("localhost", 27017, TEST_DB)

    # Insert document with data
    document = {"name": "John", "count": 0}
    insert_result = mongo_provider.insert_document(TEST_COLLECTION, document)
    print(insert_result.inserted_id)

    # Fetch data with sorting
    # query = {"age": {"$gt": 25}}
    # projection = {"name": 1, "age": 1}
    # sort = [("age", 1)]  # Sort by age in ascending order
    # results = mongo_provider.execute_query(TEST_COLLECTION, query, projection, sort)
    # for result in results:
    #     print(result)

    # bulk read
    # results = mongo_provider.bulk_read("your_collection", query, projection, sort)
    # for result in results:
    #     print(result)

    # Close the MongoDB connection
    # mongo_provider.close_connection()
