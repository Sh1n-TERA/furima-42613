# config/unicorn.rb

# アプリケーションのルートパス（sharedとcurrentの親）
app_path = File.expand_path('../../../', __FILE__)

# プロセス数
worker_processes 1

# アプリの実行ディレクトリ
working_directory "#{app_path}/current"

# PIDファイル
pid "#{app_path}/shared/tmp/pids/unicorn.pid"

# ソケット通信の設定（NginxとUnicornをつなぐ）
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"

# ログ出力
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

# 応答待ち時間
timeout 60

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

check_client_connection false
run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
  if run_once
    run_once = false
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH => e
      logger.error e
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end
