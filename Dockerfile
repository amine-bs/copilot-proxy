FROM python:3.10-slim-buster

WORKDIR /python-docker

COPY copilot_proxy/requirements.txt requirements.txt

RUN pip3 install --no-cache-dir -r requirements.txt

COPY copilot_proxy .
ENV NUM_GPUS=1
RUN export GPUS=$(seq 0 $(( NUM_GPUS - 1)) | paste -s -d ',' -)
ENV TRITON_HOST=triton
ENV TRITON_PORT=8001
ENV MODEL=codegen-6B-mono
ENV MODEL_DIR=/home/onyxia/work/models/codegen-6B-mono-1gpu
ENV HF_CACHE_DIR=/home/onyxia/work/.hf_cache
EXPOSE 5000

CMD ["uvicorn", "--host", "0.0.0.0", "--port", "5000", "app:app"]
