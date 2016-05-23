import datetime
from flask import render_template

from app import current_service
from app.main import main


@main.route("/tour/<int:page>")
def tour(page):
    return render_template(
        'views/tour/{}.html'.format(page),
        current_page=page,
        next_page=(page + 1),
        now=str(datetime.datetime.utcnow()),
        current_service=current_service
    )
