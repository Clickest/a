from icmp_server import *
import unittest

# deserialize_json() tests

class deserialize_json_tests(unittest.TestCase):

    def test_json_empty(self):
        self.assertEqual(deserialize_json("{}"), {})


if __name__ == '__main__':
    unittest.main()