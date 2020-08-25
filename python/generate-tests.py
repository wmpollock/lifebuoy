#! /usr/bin/env python3

import os
import os.path
import re
from sys import argv

for dir in argv[1:]:
    dir = os.path.normpath(dir)
    test_dir = os.path.join(dir, "tests")

    print(f"Processing {dir}")
    for root,d_names,f_names in os.walk(dir):
        if root.find(os.path.normpath("tests/")) > -1:
            continue

        for file in f_names:
            if file == "__init__.py":
                continue

            if not re.search(r"\.py$", file):
                continue
        
            print(os.path.join(root, file))
            if root.replace(dir, ""): 
                target_file =  "_".join((root.replace(dir, "").replace(os.path.sep, "_")[1:],
                        file)
                        )
            else:
                target_file = file

            import_class = target_file.replace(".py", "").replace("_", ".")
            class_name = "".join(map(lambda x: x.capitalize(), import_class.split("_")))

            target_file = os.path.join(
                test_dir,
                target_file
            )
            
            if os.path.exists(target_file):
                print("    has:", target_file)
            else:
                print("  needs:", target_file)

            with open(target_file, 'w') as file:
                file.write(f'''#!/usr/bin/env python3                
""" Unit tests for {import_class} """
import unittest            
import {import_class}

class {class_name}Test(unittest.TestCase):
    """ """
    def test_something(self):
        """ """

if __name__ == "__main__":
    unittest.main()
''')
