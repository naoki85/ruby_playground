BookRecorder::Application.config.session_store :cookie_store,
                                               key: '_book_recorder_session',
                                               :expire_after => 1.day