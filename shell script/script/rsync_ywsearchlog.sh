#!/bin/sh
/usr/bin/rsync -avz isearch@10.3.3.105:/home/isearch/yiwugou/iSearch-search-service-1.0.0/logs/ywsearch.log.* /home/data/ywsearch_log/node2
/usr/bin/rsync -avz isearch@10.3.3.106:/home/isearch/yiwugou/iSearch-search-service-1.0.0/logs/ywsearch.log.* /home/data/ywsearch_log/node3
/usr/bin/rsync -avz isearch@10.3.3.107:/home/isearch/yiwugou/iSearch-search-service-1.0.0/logs/ywsearch.log.* /home/data/ywsearch_log/node4
