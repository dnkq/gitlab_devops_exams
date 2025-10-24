from fastapi.testclient import TestClient

from users.main import app

client = TestClient(app)


def test_read_main():
    response = client.get("/api/users")
    assert response.status_code == 200
