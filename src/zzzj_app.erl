-module(zzzj_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_',[
				{"/api/news/topnews", news_topnews_handler, []},
                {"/api/news/newsrange", news_newsrange_handler, []},     
                {"/api/news/topnews_with_images", top_news_and_graphics_handler, []},  
                {"/api/news/count", news_count_by_category_handler, []},
                {"/api/news/get_all", news_get_all_by_category_handler,[]},
                {"/api/videos/latest", videos_latest_handler , []},
                {"/api/videos/popular", videos_popular_handler ,[]},
                {"/api/videos/latest_one", videos_latest_one_handler , []},
                {"/api/videos/home_video", videos_home_video_handler, []},
                {"/api/videos/count", video_count_handler, []},
                {"/api/videos/get_all", videos_get_all_handler, []},
                {"/videos", videos_pagination_handler, []},
                {"/p/:category", news_categories_handler, []},
                {"/v/:id", video_page_handler, []},                      
                {"/n/:id", news_page_handler, []},                      
				{"/css/[...]", cowboy_static, 
					[
                		{directory, {priv_dir, zzzj, ["public/css"]}},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	},
                
                {"/images/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, zzzj, ["public/images"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
                {"/js/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, zzzj, ["public/js"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
                {"/players/[...]", cowboy_static, 
                    [
                        {directory, {priv_dir, zzzj, ["public/players"]}},
                        {mimetypes, {fun mimetypes:path_to_mimes/2, default}}
                    ]
                },
            	{"/", cowboy_static, 
            		[
                		{directory, {priv_dir, zzzj, ["public"]}},
                		{file, "index.html"},
                		{mimetypes, {fun mimetypes:path_to_mimes/2, default}}
            		]
            	}
                
			 ]
		}

	]), 
    ok = application:start(lager),
    ok = application:start(crypto),
    ok = application:start(jsx),
    ok = application:start(ranch),
    ok = application:start(cowlib),
    ok = application:start(cowboy),
    ok = application:start(ibrowse),

	{ok, _} = cowboy:start_http(http,100, [{port, 9905}],[{env, [{dispatch, Dispatch}]},
                                                          {onrequest, fun request_hook_responder:set_cors/1},
                                                          {onresponse, fun error_hook_responder:respond/4}
              ]), 
    zzzj_sup:start_link().

stop(_State) ->
    ok.
