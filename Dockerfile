FROM python:3.12-slim

WORKDIR /app


# Install Python dependencies (layer ini di-cache selama requirements.txt nggak berubah)
COPY requirements.txt .
# Tambahkan parameter --default-timeout=1000
RUN pip install --default-timeout=1000 --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Expose port
EXPOSE 8000

# Run the application (tanpa --reload untuk production)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
