require "test_helper"

class ConsultationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consultation = consultations(:one)
  end

  test "should get index" do
    get consultations_url
    assert_response :success
  end

  test "should get new" do
    get new_consultation_url
    assert_response :success
  end

  test "should create consultation" do
    assert_difference("Consultation.count") do
      post consultations_url, params: { consultation: { consultation_name: @consultation.consultation_name, date: @consultation.date, email: @consultation.email, teacher_name: @consultation.teacher_name, time_end: @consultation.time_end, time_start: @consultation.time_start } }
    end

    assert_redirected_to consultation_url(Consultation.last)
  end

  test "should show consultation" do
    get consultation_url(@consultation)
    assert_response :success
  end

  test "should get edit" do
    get edit_consultation_url(@consultation)
    assert_response :success
  end

  test "should update consultation" do
    patch consultation_url(@consultation), params: { consultation: { consultation_name: @consultation.consultation_name, date: @consultation.date, email: @consultation.email, teacher_name: @consultation.teacher_name, time_end: @consultation.time_end, time_start: @consultation.time_start } }
    assert_redirected_to consultation_url(@consultation)
  end

  test "should destroy consultation" do
    assert_difference("Consultation.count", -1) do
      delete consultation_url(@consultation)
    end

    assert_redirected_to consultations_url
  end
end
