flynn create test-container

sudo flynn -a test-container docker push rkurz/test-container

--load balancing tests
flynn -a test-container scale app=2

flynn -a test-container scale app=3

--process failure tests
flynn -a test-container scale app=1

flynn -a test-container scale app=1
