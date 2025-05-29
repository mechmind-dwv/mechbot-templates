# backend/config/views/health.py
from django.http import JsonResponse
from redis import Redis
from django.db import connection
from django.conf import settings

def health_check(request):
    status = {
        'database': False,
        'redis': False,
        'status': 'ok'
    }
    
    try:
        # Check DB
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            status['database'] = True
        
        # Check Redis
        redis = Redis.from_url(settings.REDIS_URL)
        redis.ping()
        status['redis'] = True
        
    except Exception as e:
        status['status'] = str(e)
    
    return JsonResponse(status)
