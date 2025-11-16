# Use lightweight Python 3.11 base image
FROM python:3.11-slim

# Set Python environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1 \
	PYTHONUTF8=1 \
	PYTHONIOENDOCING=utf8

# Set working directory inside the container
WORKDIR /workspace

# Install required system packages (build tools & Japanese fonts)
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	fonts-ipafont-gothic \
	fonts-ipafont-mincho \
	&& rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose JupyterLab port
EXPOSE 8888

# Launch JupyterLab (no token for local development)
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--NotebookApp.token=", "--allow-root"]

