#!/usr/bin/env python3

import sys
print(f"Python version: {sys.version}")

# Test all required imports
try:
    import pandas as pd
    print(f"✓ pandas {pd.__version__}")
except ImportError as e:
    print(f"✗ pandas: {e}")

try:
    import numpy as np
    print(f"✓ numpy {np.__version__}")
except ImportError as e:
    print(f"✗ numpy: {e}")

try:
    import plotly
    print(f"✓ plotly {plotly.__version__}")
except ImportError as e:
    print(f"✗ plotly: {e}")

try:
    import plotly.express as px
    print("✓ plotly.express imported successfully")
except ImportError as e:
    print(f"✗ plotly.express: {e}")

print("\nAll tests completed!")
