export SECRET_KEY_BASE=`cat .production_key`
rails s -e production -p 25252 -b 0.0.0.0
