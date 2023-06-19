#!/bin/bash

build_html_head(){
    echo "<!DOCTYPE html>" > public/index.html
    echo "<html lang="en">" >> public/index.html
    echo "<head>" >> public/index.html
    echo "<meta charset="utf-8" />" >> public/index.html
    echo "<meta http-equiv="X-UA-Compatible" content="IE=edge" />" >> public/index.html
    echo "<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />" >> public/index.html
    echo "<meta name="description" content="" />" >> public/index.html
    echo "<meta name="author" content="" />" >> public/index.html
    echo "<title>Dashboard - SB Admin</title>" >> public/index.html
    echo "<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />" >> public/index.html
    echo "<link href="css/styles.css" rel="stylesheet" />" >> public/index.html
    echo "<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>" >> public/index.html
    echo "</head>" >> public/index.html
}

build_html_nav(){
    echo "<body class="sb-nav-fixed">"  >> public/index.html
    echo "<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">" >> public/index.html
    echo "<!-- Navbar Brand-->"     >> public/index.html
    echo "<a class="navbar-brand ps-3" href="index.html">Start Bootstrap</a>" >> public/index.html
    echo "<!-- Sidebar Toggle-->"   >> public/index.html
    echo "<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>" >> public/index.html
    echo "<!-- Navbar Search-->"    >> public/index.html
    echo "<form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">" >> public/index.html
    echo "<div class="input-group">" >> public/index.html
    echo "<input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />" >> public/index.html
    echo "<button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>" >> public/index.html
    echo "</div>" >> public/index.html
    echo "</form>" >> public/index.html
    echo "<!-- Navbar-->" >> public/index.html
    echo "<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">" >> public/index.html
    echo "<li class="nav-item dropdown">" >> public/index.html
    echo "<a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>" >> public/index.html
    echo "<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">" >> public/index.html
    echo "<li><a class="dropdown-item" href="#!">Settings</a></li>" >> public/index.html
    echo "<li><a class="dropdown-item" href="#!">Activity Log</a></li>" >> public/index.html
    echo "<li><hr class="dropdown-divider" /></li>" >> public/index.html
    echo "<li><a class="dropdown-item" href="#!">Logout</a></li>" >> public/index.html
    echo "</ul>" >> public/index.html
    echo "</li>" >> public/index.html
    echo "</ul>" >> public/index.html
    echo "</nav>" >> public/index.html
}

build_html_body(){
    echo "<div id="layoutSidenav">" >> public/index.html

    echo "<div id="layoutSidenav_nav">" >> public/index.html
    echo "</div>" >> public/index.html

    echo "<div id="layoutSidenav_content">" >> public/index.html
    echo "<main>" >> public/index.html

    for db in $(ls public/output/images/histogram); do
        echo "<h3>$db</h3>" >> public/index.html
        for table in $(ls public/output/images/histogram/$db); do
            echo "<h4>$table</h4>" >> public/index.html
            for $histogram in $(ls public/output/images/histogram/$db); do
                
                echo "<img src=\"output/images/histogram/$db/$table/$histobram\">" >> public/index.html
            done
        done
    done
    
    echo "</main>" >> public/index.html
    echo "</div>" >> public/index.html

    echo "</div>" >> public/index.html
}

build_html_footer(){

                    
    echo "<footer class="py-4 bg-light mt-auto">" >> public/index.html
    echo "<div class="container-fluid px-4">" >> public/index.html
    echo "<div class="d-flex align-items-center justify-content-between small">" >> public/index.html
    echo "<div class="text-muted">Copyright &copy; Your Website 2023</div>" >> public/index.html
    echo "<div>" >> public/index.html
    echo "<a href="#">Privacy Policy</a>" >> public/index.html
    echo "&middot;" >> public/index.html
    echo "<a href="#">Terms &amp; Conditions</a>" >> public/index.html
    echo "</div>" >> public/index.html
    echo "</div>" >> public/index.html
    echo "</div>" >> public/index.html
    echo "</footer>" >> public/index.html
    echo "</div>" >> public/index.html
    
    echo "<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>" >> public/index.html
    echo "<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>" >> public/index.html
    echo "<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>" >> public/index.html

    #echo "<script src="js/scripts.js"></script>" >> public/index.html
    #echo "<script src="assets/demo/chart-area-demo.js"></script>" >> public/index.html
    #echo "<script src="assets/demo/chart-bar-demo.js"></script>" >> public/index.html
    #echo "<script src="js/datatables-simple-demo.js"></script>" >> public/index.html
    
    echo "</body>" >> public/index.html
    echo "</html>" >> public/index.html
}

build_html_head
build_html_body
build_html_footer