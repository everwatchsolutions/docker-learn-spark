# Learning Spark (2.2.1)
## Intro

This project uses Docker to launch you into an environment with spark locally installed and some data prepopulated.

## Install software

### mac
1. install Docker (http://docs.docker.com/mac/started/)

### homebrew (mac)
1. brew install docker-machine
2. brew install docker
3. docker-machine create --driver virtualbox learn-spark
4. docker-machine env learn-spark
5. eval "$(docker-machine env learn-spark)"

## Build and Run the docker container ...
from the project directory.  The build will take a long time...

1. docker build -t aces/learn-spark .
2. docker run -it --rm aces/learn-spark

## We are now logged into the spark shell
this may take a while ... but eventually you will see the spark ascii art and the scala>

### Load the data into a DataFrame

  ``` 
  val df = spark.sqlContext.jsonFile("data/enron-data.json.gz")
  ```
  
### Count the records

  ``` 
  df.count()
  ```  

### Print the schema

  ``` 
  df.printSchema()
  ```  

### Show some records

  ``` 
  df.show()
  ```  

### Show some records (one column)

  ``` 
  df.select("sender").show()
  ```  

### Show some records (multiple columns)

  ``` 
  df.select("sender","date").show()
  ```  


### Group by

  ``` 
  df.groupBy("sender").count().show()
  ```  
  
### Group by with sort

  ``` 
  df.groupBy("sender").count().sort($"count".desc).show()
  ```    
  
### Limit results

``` 
df.groupBy("sender").count().sort($"count".desc).limit(2).show()
```  