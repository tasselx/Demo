
window.onload = function(){

    // Firefox和Chrome早期版本中带有前缀
    //var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;

    var src = window.location.href;
    //log(src);
    
    var video = document.querySelector("video");
    if(video){
        alert(video.src+" location url:"+src);
    }
    
    // 选择目标节点
//    var target = document.body;

    // 创建观察者对象
//    var observer = new MutationObserver(function(mutations){
//                                        domCheck();
//
//                                        });

    // 配置观察选项:
//    var config = { attributes: true, childList: true, characterData: true }
    
    // 传入目标节点和观察选项
//    observer.observe(target, config);
    
    // 随后,你还可以停止观察
    //observer.disconnect();
}

    var domCheck = function (){
    }
    
    
    // 参数同上
    var throttle = function(fn, delay, mustRunDelay){
        var timer = null;
        var t_start;
        return function(){
            var context = this, args = arguments, t_curr = +new Date();
            
            // 清除定时器
            clearTimeout(timer);
            
            // 函数初始化判断
            if(!t_start){
                t_start = t_curr;
            }
            
            // 超时（指定的时间间隔）判断
            if(t_curr - t_start >= mustRunDelay){
                fn.apply(context, args);
                t_start = t_curr;
            }
            else {
                timer = setTimeout(function(){
                                   fn.apply(context, args);
                                   }, delay);
            }
        };
    };

function log(string){
    window.webkit.messageHandlers.jsCallOC.postMessage(string);
}

