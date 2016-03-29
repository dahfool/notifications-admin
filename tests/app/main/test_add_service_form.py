from app.main.forms import AddServiceForm
from werkzeug.datastructures import MultiDict


def test_form_should_have_errors_when_duplicate_service_is_added(app_):
    def _get_form_names():
        return ['some service', 'more names']
    with app_.test_request_context():
        form = AddServiceForm(_get_form_names,
                              formdata=MultiDict([('name', 'some service')]))
        form.validate()
        assert {'name': ['This service name is already in use']} == form.errors


def test_form_should_have_errors_when_duplicate_service_name_with_mixed_case(app_):
    def _get_form_names():
        return ['some service', 'more names']
    with app_.test_request_context():
        form = AddServiceForm(_get_form_names,
                              formdata=MultiDict([('name', 'SomE SERVICE')]))
        form.validate()
        assert {'name': ['This service name is already in use']} == form.errors


def test_form_should_not_have_errors_when_service_name_is_unique(app_):
    def _get_form_names():
        return ['some service', 'more names']
    with app_.test_request_context():
        form = AddServiceForm(_get_form_names,
                              formdata=MultiDict([('name', 'Some Service 123')]))
        form.validate()
        assert {} == form.errors
