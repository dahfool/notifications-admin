from flask import render_template

from app.main import main


headings = [
    'Start with a template',
    'Add recipients',
    'Send your messages',
]


@main.route("/tour/<int:page>")
def tour(page):
    return render_template(
        'views/tour/{}.html'.format(page),
        current_page=page,
        next_page=(page + 1),
        heading=headings[page - 1]
    )
