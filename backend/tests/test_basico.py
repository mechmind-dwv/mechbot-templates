import unittest


class TestEjemplo(unittest.TestCase):
    def test_suma(self):
        self.assertEqual(1 + 1, 2)


if __name__ == "__main__":
    unittest.main()
