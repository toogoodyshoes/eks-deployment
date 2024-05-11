from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routers import counter

app = FastAPI()

origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(counter.router)

# @app.on_event("startup")
# async def startup():
#     provider = MongoDBDataProvider("localhost", 27017, DB_NAME)

if __name__ == '__main__':
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
