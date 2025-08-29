import xml.etree.ElementTree as ET


def findint(element: ET.Element, path: str, default=None):
    value = element.find(path)
    if value is not None:
        try:
            value = int(value.text)
            return value
        except ValueError:
            print(f"Warning: Could not convert '{value.text}' to int at path '{path}'")
            return default
    return default


def findfloat(element: ET.Element, path: str, default=None):
    value = element.find(path)
    if value is not None:
        try:
            value = float(value.text)
            return value
        except ValueError:
            print(f"Warning: Could not convert '{value.text}' to float at path '{path}'")
            return default
    return default