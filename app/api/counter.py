from fastapi import FastAPI
from mongo_data_provider import MongoDBDataProvider

app = FastAPI()

provider = None
DB_NAME = "visitors"
DB_COLLECTION = "visit_count"

# @app.on_event("startup")
# async def startup():
#     provider = MongoDBDataProvider("localhost", 27017, DB_NAME)


@app.post("/update_count")
async def update_count():
    client = MongoDBDataProvider("localhost", 27017, DB_NAME)
    query = {"name": "Nihar"}
    document = client.check_existing(DB_COLLECTION, query)
    return {"message": {"visitor_count": document['visits']}}

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
