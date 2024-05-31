import os
import logging

from fastapi import FastAPI
from mangum import Mangum
from pydantic import BaseModel

class Item(BaseModel):
    key1: str
    key2: str | None = None
    key3: float

logger = logging.getLogger()
logger.setLevel("INFO")

print("Start....")

app = FastAPI()

@app.get("/")
def read_root():
    logger.info("FastAPI running on AWS Lambda and handle GET method at root")
    print("FastAPI running on AWS Lambda and handle GET method at root")
    return {"message": "FastAPI running on AWS Lambda and handle GET method at root"}

@app.get("/items")
def read_item():
    logger.info("FastAPI running on AWS Lambda and handle GET method at /items")
    return {"message": "FastAPI running on AWS Lambda and handle GET method at /items"}

@app.post("/items")
async def create_item(item: Item):
    logger.info("FastAPI running on AWS Lambda and handle POST method at /items")
    logger.info(item)
    return item

lambda_handler = Mangum(app, lifespan="off")
