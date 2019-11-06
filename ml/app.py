from starlette.applications import Starlette
from starlette.templating import Jinja2Templates
from starlette.responses import JSONResponse
from starlette.middleware.cors import CORSMiddleware
import uvicorn
from io import BytesIO
from fastai import *
from fastai.vision import *

app = Starlette()

# Config
app.add_middleware(CORSMiddleware, allow_origins=[
                   '*'], allow_headers=['X-Requested-With', 'Content-Type'])
model_classify_food_pkl = "foodv1.pkl"
path = Path(__file__).parent

# Deep Learning Models
model_classify_food = load_learner(path, model_classify_food_pkl)


@app.route('/', methods=['GET'])
async def home(request):
    return JSONResponse('Server Reached')


@app.route('/classify_food', methods=['POST'])
async def classify(request):
    data = await request.form()
    img_bytes = await (data['file'].read())
    img = open_image(BytesIO(img_bytes))
    prediction = model_classify_food.predict(img)[0]
    return JSONResponse({'result': str(prediction)})


if __name__ == '__main__':
    uvicorn.run(app, port=5032)
