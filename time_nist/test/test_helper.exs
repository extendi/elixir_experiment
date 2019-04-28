ExUnit.start()
Application.ensure_all_started(:mox)

Mox.defmock(TimeNist.ClientMock, for: TimeNist.Interface)
