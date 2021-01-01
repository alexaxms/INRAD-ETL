import json
import os
import sys

import pika

from SQL import UserDimension, session, PatientDimension


def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=os.getenv('RABBIT_HOST')))
    channel = connection.channel()

    channel.queue_declare(queue='inrad')

    def callback(ch, method, properties, body):
        data = body.decode("UTF-8")
        transform_and_insert(json.loads(data))

    channel.basic_consume(queue='inrad', on_message_callback=callback, auto_ack=True)

    print(' [*] Waiting for messages. To exit press CTRL+C')
    channel.start_consuming()


def transform_and_insert(data: dict):
    user = data.get("user")
    user_dimension = UserDimension(full_name=f"{user.get('first_name')} {user.get('last_name')} ",
                                   role=user.get("role"))
    patient = data.get("patient")
    patient_dimension = PatientDimension(name=patient["name"], last_name=patient["last_name"],
                                         phone_number=patient["phone_number"], identifier=patient["identifier"],
                                         age=patient["age"], gender=patient["gender"], blood_type=patient["blood_type"])
    session.add(user_dimension)
    session.add(patient_dimension)
    session.commit()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
