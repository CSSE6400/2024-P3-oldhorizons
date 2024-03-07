# specify base image for subsequent instructions
FROM ubuntu:22.04

# execute  commands on current layer and store changes on new layer
RUN apt-get update && apt-get install -y python3 python3-pip postgresql-client libpq-dev

#install poetry
RUN pip3 install poetry

#set working directory
WORKDIR /app

# install dependencies
COPY pyproject.toml ./
RUN poetry install --no-root

#copy application into container
COPY todo todo

#running app
CMD ["poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]


# ALTERNATIVE: PYTHON BASE
# FROM python:3.10 
# # Install pipenv 
# RUN pip3 install poetry 
# # Setting the working directory 
# WORKDIR /app 
# # Install pipenv dependencies 
# COPY pyproject.toml ./ 
# RUN poetry install --no-root 
# # Copying our application into the container 
# COPY todo todo 
# # Running our application 
# CMD ["poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]
 