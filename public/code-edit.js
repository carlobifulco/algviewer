
    

  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>code-edit.js at master from awwaiid's jquery-textarea-autoindent - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />

    <link href="https://assets1.github.com/stylesheets/bundle_common.css?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" media="screen" rel="stylesheet" type="text/css" />
<link href="https://assets0.github.com/stylesheets/bundle_github.css?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript" charset="utf-8">
      var GitHub = {}
      var github_user = null
      
    </script>
    <script src="https://assets2.github.com/javascripts/jquery/jquery-1.4.2.min.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>
    <script src="https://assets3.github.com/javascripts/bundle_common.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>
<script src="https://assets3.github.com/javascripts/bundle_github.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>

        <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "awwaiid/jquery-textarea-autoindent"
      })
    </script>

    
  
    
  

  <link href="https://github.com/awwaiid/jquery-textarea-autoindent/commits/master.atom" rel="alternate" title="Recent Commits to jquery-textarea-autoindent:master" type="application/atom+xml" />

        <meta name="description" content="Autoindent text in a textarea -- good for code editing" />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "awwaiid/jquery-textarea-autoindent";
      GitHub.currentRef = 'master';
    </script>
  

            <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

  </head>

  

  <body class="logged_out ">
    

    
      <script type="text/javascript">
        var _kmq = _kmq || [];
        function _kms(u){
          var s = document.createElement('script'); var f = document.getElementsByTagName('script')[0]; s.type = 'text/javascript'; s.async = true;
          s.src = u; f.parentNode.insertBefore(s, f);
        }
        _kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/406e8bf3a2b8846ead55afb3cfaf6664523e3a54.1.js');
      </script>
    

    

    

    

    <div class="subnavd" id="main">
      <div id="header" class="true">
        
          <a class="logo boring" href="https://github.com">
            <img src="/images/modules/header/logov3.png?changed" class="default" alt="github" />
            <![if !IE]>
            <img src="/images/modules/header/logov3-hover.png" class="hover" alt="github" />
            <![endif]>
          </a>
        
        
        <div class="topsearch">
  
    <ul class="nav logged_out">
      <li><a href="https://github.com">Home</a></li>
      <li class="pricing"><a href="/plans">Pricing and Signup</a></li>
      <li><a href="https://github.com/training">Training</a></li>
      <li><a href="https://gist.github.com">Gist</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="https://github.com/login">Login</a></li>
    </ul>
  
</div>

      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">

      

      <div class="title-actions-bar">
        <h1>
          <a href="/awwaiid">awwaiid</a> / <strong><a href="https://github.com/awwaiid/jquery-textarea-autoindent">jquery-textarea-autoindent</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/awwaiid/jquery-textarea-autoindent/admin" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/awwaiid/jquery-textarea-autoindent/toggle_watch" class="minibutton btn-watch " id="watch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/awwaiid/jquery-textarea-autoindent/toggle_watch" class="minibutton btn-watch " id="unwatch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          
            <li class="for-notforked" style="display:none"><a href="/awwaiid/jquery-textarea-autoindent/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
            <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          

          
        
      
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/awwaiid/jquery-textarea-autoindent/watchers" title="Watchers" class="tooltipped downwards">1</a></li>
          <li class="forks"><a href="/awwaiid/jquery-textarea-autoindent/network" title="Forks" class="tooltipped downwards">0</a></li>
        </ul>
      </li>
    </ul>

      </div>

        
  <ul class="tabs">
    <li><a href="https://github.com/awwaiid/jquery-textarea-autoindent/tree/master" class="selected" highlight="repo_source">Source</a></li>
    <li><a href="https://github.com/awwaiid/jquery-textarea-autoindent/commits/master" highlight="repo_commits">Commits</a></li>
    <li><a href="/awwaiid/jquery-textarea-autoindent/network" highlight="repo_network">Network</a></li>
    <li><a href="/awwaiid/jquery-textarea-autoindent/pulls" highlight="repo_pulls">Pull Requests (0)</a></li>

    

    
      
      <li><a href="/awwaiid/jquery-textarea-autoindent/issues" highlight="issues">Issues (0)</a></li>
    

                    
    <li><a href="/awwaiid/jquery-textarea-autoindent/graphs" highlight="repo_graphs">Graphs</a></li>

    <li class="contextswitch nochoices">
      <span class="toggle leftwards" >
        <em>Branch:</em>
        <code>master</code>
      </span>
    </li>
  </ul>

  <div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
  <div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

  <div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (1)</a>
      <ul>
        
          
            <li><strong>master &#x2713;</strong></li>
            
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown defunct">Switch Tags (0)</a>
      
    </li>
    <li>
    
    <a href="/awwaiid/jquery-textarea-autoindent/branches" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>

  
  
  
  
  
  



        
    <div id="repo_details" class="metabox clearfix">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

        <a href="/awwaiid/jquery-textarea-autoindent/downloads" class="download-source" id="download_button" title="Download source, tagged packages and binaries."><span class="icon"></span>Downloads</a>

      <div id="repository_desc_wrapper">
      <div id="repository_description" rel="repository_description_edit">
        
          <p>Autoindent text in a textarea -- good for code editing
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>

      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/awwaiid/jquery-textarea-autoindent/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="af4ca3004ea424d43f918ba1bf19ed51bcc0894c" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="Autoindent text in a textarea -- good for code editing">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://thelackthereof.org/" rel="nofollow">http://thelackthereof.org/</a></p>
      </div>

      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/awwaiid/jquery-textarea-autoindent/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="af4ca3004ea424d43f918ba1bf19ed51bcc0894c" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="http://thelackthereof.org/">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>
      </div>
      <div class="rule "></div>
            <div id="url_box" class="url-box">
        <ul class="clone-urls">
          
            
            <li id="http_clone_url"><a href="http://github.com/awwaiid/jquery-textarea-autoindent.git" data-permissions="Read-Only">HTTP</a></li>
            <li id="public_clone_url"><a href="git://github.com/awwaiid/jquery-textarea-autoindent.git" data-permissions="Read-Only">Git Read-Only</a></li>
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets2.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets2.github.com/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      









<script type="text/javascript">
  GitHub.currentCommitRef = 'master'
  GitHub.currentRepoOwner = 'awwaiid'
  GitHub.currentRepo = "jquery-textarea-autoindent"
  GitHub.downloadRepo = '/awwaiid/jquery-textarea-autoindent/archives/master'
  GitHub.revType = "master"

  GitHub.controllerName = "blob"
  GitHub.actionName     = "show"
  GitHub.currentAction  = "blob#show"

  

  
</script>








  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/awwaiid/jquery-textarea-autoindent/commit/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df">Clean out junk from example html</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img src="https://secure.gravatar.com/avatar/1dc66046def93740605f5e63a6aacd71?s=140&d=https%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="30" height="30"  />
        </div>
        <div class="name"><a href="/awwaiid">awwaiid</a> <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2007-07-29 19:54:20">Sun Jul 29 19:54:20 -0700 2007</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/awwaiid/jquery-textarea-autoindent/commit/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df" hotkey="c">4ef6ae5602e3cb3ce3cd</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/awwaiid/jquery-textarea-autoindent/tree/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df" hotkey="t">a47685e942a0b5366bf1</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/awwaiid/jquery-textarea-autoindent/tree/45e93b3769d0e533bc3edec55ba9bbb9de96aebf" hotkey="p">45e93b3769d0e533bc3e</a>
      

    </div>
  </div>

    </div>
  </div>



  
    <div id="path">
      <b><a href="/awwaiid/jquery-textarea-autoindent/tree/master">jquery-textarea-autoindent</a></b> / code-edit.js       <span style="display:none" id="clippy_991">code-edit.js</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets2.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_991&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets2.github.com/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_991&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div id="files">
      <div class="file">
        <div class="meta">
          <div class="info">
            <span class="icon"><img alt="Txt" height="16" src="https://assets3.github.com/images/icons/txt.png?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" width="16" /></span>
            <span class="mode" title="File Mode">100644</span>
            
              <span>21 lines (17 sloc)</span>
            
            <span>0.456 kb</span>
          </div>
          <ul class="actions">
            
              <li><a id="file-edit-link" href="#" rel="/awwaiid/jquery-textarea-autoindent/file-edit/__ref__/code-edit.js">edit</a></li>
            
            <li><a href="/awwaiid/jquery-textarea-autoindent/raw/master/code-edit.js" id="raw-url">raw</a></li>
            
              <li><a href="/awwaiid/jquery-textarea-autoindent/blame/master/code-edit.js">blame</a></li>
            
            <li><a href="/awwaiid/jquery-textarea-autoindent/commits/master/code-edit.js">history</a></li>
          </ul>
        </div>
        
  <div class="data type-javascript">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <pre class="line_numbers"><span id="LID1" rel="#L1">1</span>
<span id="LID2" rel="#L2">2</span>
<span id="LID3" rel="#L3">3</span>
<span id="LID4" rel="#L4">4</span>
<span id="LID5" rel="#L5">5</span>
<span id="LID6" rel="#L6">6</span>
<span id="LID7" rel="#L7">7</span>
<span id="LID8" rel="#L8">8</span>
<span id="LID9" rel="#L9">9</span>
<span id="LID10" rel="#L10">10</span>
<span id="LID11" rel="#L11">11</span>
<span id="LID12" rel="#L12">12</span>
<span id="LID13" rel="#L13">13</span>
<span id="LID14" rel="#L14">14</span>
<span id="LID15" rel="#L15">15</span>
<span id="LID16" rel="#L16">16</span>
<span id="LID17" rel="#L17">17</span>
<span id="LID18" rel="#L18">18</span>
<span id="LID19" rel="#L19">19</span>
<span id="LID20" rel="#L20">20</span>
<span id="LID21" rel="#L21">21</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre><div class='line' id='LC1'><span class="cm">/* Code editor */</span></div><div class='line' id='LC2'><br/></div><div class='line' id='LC3'><span class="kd">function</span> <span class="nx">autoindent</span><span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC4'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">k</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">keyCode</span> <span class="o">||</span> <span class="nx">e</span><span class="p">.</span><span class="nx">charCode</span><span class="p">;</span></div><div class='line' id='LC5'>&nbsp;&nbsp;<span class="k">if</span> <span class="p">(</span><span class="nx">k</span> <span class="o">!=</span> <span class="mi">13</span><span class="p">)</span> <span class="k">return</span> <span class="kc">true</span><span class="p">;</span></div><div class='line' id='LC6'>&nbsp;&nbsp;<span class="nx">e</span><span class="p">.</span><span class="nx">preventDefault</span><span class="p">();</span></div><div class='line' id='LC7'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">range</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">).</span><span class="nx">getSelection</span><span class="p">();</span></div><div class='line' id='LC8'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">pos</span> <span class="o">=</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span><span class="p">;</span></div><div class='line' id='LC9'>&nbsp;&nbsp;<span class="kd">var</span> <span class="nx">ws</span> <span class="o">=</span> <span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">).</span><span class="nx">val</span><span class="p">().</span><span class="nx">substr</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="nx">pos</span><span class="p">);</span></div><div class='line' id='LC10'>&nbsp;&nbsp;<span class="nx">ws</span> <span class="o">=</span> <span class="nx">ws</span><span class="p">.</span><span class="nx">match</span><span class="p">(</span><span class="sr">/(^|\n)([ ]*)[^\n]*$/</span><span class="p">);</span></div><div class='line' id='LC11'>&nbsp;&nbsp;<span class="nx">ws</span> <span class="o">=</span> <span class="nx">ws</span><span class="p">[</span><span class="mi">2</span><span class="p">];</span></div><div class='line' id='LC12'>&nbsp;&nbsp;<span class="nx">ws</span> <span class="o">=</span> <span class="s2">"\n"</span> <span class="o">+</span> <span class="nx">ws</span><span class="p">;</span></div><div class='line' id='LC13'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">).</span><span class="nx">replaceSelection</span><span class="p">(</span><span class="nx">ws</span><span class="p">);</span></div><div class='line' id='LC14'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="k">this</span><span class="p">).</span><span class="nx">setSelection</span><span class="p">({</span><span class="nx">pos</span><span class="o">:</span> <span class="nx">pos</span> <span class="o">+</span> <span class="nx">ws</span><span class="p">.</span><span class="nx">length</span><span class="p">});</span></div><div class='line' id='LC15'><span class="p">}</span></div><div class='line' id='LC16'><br/></div><div class='line' id='LC17'><span class="nx">$</span><span class="p">(</span><span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC18'>&nbsp;&nbsp;<span class="nx">$</span><span class="p">(</span><span class="s1">&#39;textarea.autoindent&#39;</span><span class="p">).</span><span class="nx">keypress</span><span class="p">(</span><span class="nx">autoindent</span><span class="p">);</span></div><div class='line' id='LC19'><span class="p">});</span></div><div class='line' id='LC20'><br/></div><div class='line' id='LC21'><br/></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div>


      </div>
    </div>
  


    </div>
  
      
    </div>

    <div id="footer" class="clearfix">
      <div class="site">
        <div class="sponsor">
          <a href="http://www.rackspace.com" class="logo">
            <img alt="Dedicated Server" src="https://assets0.github.com/images/modules/footer/rackspace_logo.png?v2?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" />
          </a>
          Powered by the <a href="http://www.rackspace.com ">Dedicated
          Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
          Computing</a> of Rackspace Hosting<span>&reg;</span>
        </div>

        <ul class="links">
          <li class="blog"><a href="https://github.com/blog">Blog</a></li>
          <li><a href="http://support.github.com">Support</a></li>
          <li><a href="https://github.com/training">Training</a></li>
          <li><a href="http://jobs.github.com">Job Board</a></li>
          <li><a href="http://shop.github.com">Shop</a></li>
          <li><a href="https://github.com/contact">Contact</a></li>
          <li><a href="http://develop.github.com">API</a></li>
          <li><a href="http://status.github.com">Status</a></li>
        </ul>
        <ul class="sosueme">
          <li class="main">&copy; 2010 <span id="_rrt" title="0.12024s from fe2.rs.github.com">GitHub</span> Inc. All rights reserved.</li>
          <li><a href="/site/terms">Terms of Service</a></li>
          <li><a href="/site/privacy">Privacy</a></li>
          <li><a href="https://github.com/security">Security</a></li>
        </ul>
      </div>
    </div><!-- /#footer -->

    
      
      
        <!-- current locale:  -->
        <div class="locales">
          <div class="site">

            <ul class="choices clearfix limited-locales">
              <li><span class="current">English</span></li>
              
                
                  <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                
              
              <li class="all"><a href="#" class="minibutton btn-forward js-all-locales"><span><span class="icon"></span>See all available languages</span></a></li>
            </ul>

            <div class="all-locales clearfix">
              <h3>Your current locale selection: <strong>English</strong>. Choose another?</h3>
              
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=en">English</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=af">Afrikaans</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ca">Català</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=cs">Čeština</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=es">Español</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=hr">Hrvatski</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=id">Indonesia</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=it">Italiano</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=nl">Nederlands</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=no">Norsk</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pl">Polski</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=sr">Српски</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=sv">Svenska</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                    
                  
                </ul>
              
            </div>

          </div>
          <div class="fade"></div>
        </div>
      
    

    <script>window._auth_token = "af4ca3004ea424d43f918ba1bf19ed51bcc0894c"</script>
    <div id="keyboard_shortcuts_pane" style="display:none">
  <h2>Keyboard Shortcuts</h2>

  <div class="columns threecols">
    <div class="column first">
      <h3>Site wide shortcuts</h3>
      <dl class="keyboard-mappings">
        <dt>s</dt>
        <dd>Focus site search</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>?</dt>
        <dd>Bring up this help dialog</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <h3>Commit list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Open tree</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>p</dt>
        <dd>Open parent</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>c <em>or</em> o <em>or</em> enter</dt>
        <dd>Open commit</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <h3>Pull request list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.columns.last -->
  </div><!-- /.columns.equacols -->

  <div class="rule"></div>

  <h3>Issues</h3>

  <div class="columns threecols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>x</dt>
        <dd>Toggle select target</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <dl class="keyboard-mappings">
        <dt>I</dt>
        <dd>Mark selected as read</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>U</dt>
        <dd>Mark selected as unread</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>e</dt>
        <dd>Close selected</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>y</dt>
        <dd>Remove selected from view</dd>
      </dl>
    </div><!-- /.column.middle -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>c</dt>
        <dd>Create issue</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>l</dt>
        <dd>Create label</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>i</dt>
        <dd>Back to inbox</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>u</dt>
        <dd>Back to issues</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>/</dt>
        <dd>Focus issues search</dd>
      </dl>
    </div>
  </div>

  <div class="rule"></div>

  <h3>Network Graph</h3>
  <div class="columns equacols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>← <em>or</em> h</dt>
        <dd>Scroll left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>→ <em>or</em> l</dt>
        <dd>Scroll right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↑ <em>or</em> k</dt>
        <dd>Scroll up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↓ <em>or</em> j</dt>
        <dd>Scroll down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Toggle visibility of head labels</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>shift ← <em>or</em> shift h</dt>
        <dd>Scroll all the way left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift → <em>or</em> shift l</dt>
        <dd>Scroll all the way right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↑ <em>or</em> shift k</dt>
        <dd>Scroll all the way up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↓ <em>or</em> shift j</dt>
        <dd>Scroll all the way down</dd>
      </dl>
    </div><!-- /.column.last -->
  </div>

</div>
    

    <!--[if IE 8]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie8")
    </script>
    <![endif]-->

    <!--[if IE 7]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie7")
    </script>
    <![endif]-->

    <script type="text/javascript">
      _kmq.push(['trackClick', 'entice-signup-button', 'Entice banner clicked']);
      
    </script>
    
  </body>
</html>

