from fastapi import APIRouter

from database import client, DB_COLLECTION

router = APIRouter(
    prefix='/counter',
    tags=['counter']
)


@router.post("/update_count")
async def update_count():

    query = {"name": "Nihar"}
    document = client.check_existing(DB_COLLECTION, query)
    return {"message": {"visitor_count": document['visits']}}
