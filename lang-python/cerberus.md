# cerberus(validation framework)

pythonのバリデーションフレームワーク。

[Welcome to Cerberus — Cerberus is a lightweight and extensible data validation library for Python](https://docs.python-cerberus.org/en/stable/index.html)

## useit

```bash
from cerberus import Validator

def test_cerberus():
    li = [
        {"name": "alice", "age": 7},
        {"name": "bob", "age": "28"},
        {"name": "charlie"},
    ]
    schema = {
        "name": {"type": "string"},
        "age": {"type": "integer", "min": 10, "required": True},
    }
    v = Validator(schema)
    for d in li:
        v.validate(d)
        print("errors", d, v._errors)
    # errors {'name': 'alice', 'age': 7} {'age': ['min value is 10']}
    # errors {'name': 'bob', 'age': '28'} {'age': ['must be of integer type']}
    # errors {'name': 'charlie'} {'age': ['required field']}
```

## 逆引き

### 複数の値の中に存在するならOK

[Validation Rules](https://docs.python-cerberus.org/en/stable/validation-rules.html#allowed)

```python
>>> v.schema = {'role': {'type': 'list', 'allowed': ['agent', 'client', 'supplier']}}
>>> v.validate({'role': ['agent', 'supplier']})
True

>>> v.validate({'role': ['intern']})
False
>>> v.errors
{'role': ["unallowed values ('intern',)"]}

>>> v.schema = {'role': {'type': 'string', 'allowed': ['agent', 'client', 'supplier']}}
>>> v.validate({'role': 'supplier'})
True

>>> v.validate({'role': 'intern'})
False
>>> v.errors
{'role': ['unallowed value intern']}

>>> v.schema = {'a_restricted_integer': {'type': 'integer', 'allowed': [-1, 0, 1]}}
>>> v.validate({'a_restricted_integer': -1})
True

>>> v.validate({'a_restricted_integer': 2})
False
>>> v.errors
{'a_restricted_integer': ['unallowed value 2']}
```

### 任意のfield名を許可

スキーマはfield名を決め打ちで行う。ユーザーが自由なfield名を定義して、その値だけをバリデーションする場合はスキーマを動的に作成する。

[In Cerberus (Python) is there a way to create a schema that allows any key name in a dictionary? - Stack Overflow](https://stackoverflow.com/questions/70087015/in-cerberus-python-is-there-a-way-to-create-a-schema-that-allows-any-key-name)

```python
v = cerberus.Validator()
document = {"rand_value": {"key1": "val1", "key2": "val2"}, 
            "another_rand_value": {"key1": "val1", "key2": "val2"}}
fieldrule = {"type": "dict", "keysrules": {"type": "string"}}
v.validate(document, {field: fieldrule for field in document})
```
