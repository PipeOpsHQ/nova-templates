resource "kubectl_manifest" "default_backend" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: custom-error-pages
      namespace: kube-system
    data:
      404.html: |
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
              href="https://fonts.cdnfonts.com/css/niveau-grotesk-regular"
              rel="stylesheet"
            />
            <title>404 | Page Not Found</title>
            <style>
              * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Niveau Grotesk", sans-serif;
              }

              body {
                background-color: #18181a;
              }

              img {
                width: 160px;
              }

              .container {
                max-width: 95%;
                margin: 0 auto;
              }

              header {
                padding: 2rem 0;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
              }

              main {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                text-align: center;
              }

              section {
                display: flex;
                justify-content: space-between;
                gap: 3em;
                flex-wrap: wrap;
                align-items: center;
                max-width: 1300px;
                width: 90%;
                margin: 0 auto;
              }

              h1 {
                font-size: clamp(2.3rem, 6vw, 3rem);
                font-weight: 500;
                text-align: left;
                line-height: 111%;
                color: #fff;
                background: linear-gradient(
                    94deg,
                    rgba(255, 255, 255, 0.72) 42.56%,
                    rgba(255, 255, 255, 0.24) 63.66%,
                    rgba(255, 255, 255, 0.48) 83.86%
                  )
                  text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 0.3em;
              }

              p {
                color: rgba(255, 255, 255, 0.46);
                max-width: 562px;
                text-align: left;
                font-size: clamp(0.8rem, 5vw, 1.3rem);
                font-weight: 500;
                line-height: 150%;
              }

              section img {
                width: 30vw;
                min-width: 302px;
              }

              a {
                text-decoration: none;
                color: #d8d8d8;
                text-decoration: underline;
              }

              section a.home-link {
                border-width: 1px;
                border-style: solid;
                opacity: 0.7;
                border-radius: 4rem;
                color: #fff;
                padding: 1em 2em;
                text-decoration: none;
                border-image: linear-gradient(
                  90deg,
                  rgb(79, 33, 234) 0%,
                  rgb(190, 200, 255) 33%,
                  rgb(255, 213, 211) 66%,
                  rgb(255, 106, 106) 100%
                );
                background: linear-gradient(#0e0e0f, #0e0e0f) padding-box,
                  linear-gradient(
                      90deg,
                      rgb(79, 33, 234) 0%,
                      rgb(190, 200, 255) 33%,
                      rgb(255, 213, 211) 66%,
                      rgb(255, 106, 106) 100%
                    )
                    border-box;
                font-size: 1rem;
                display: block;
                width: fit-content;
                margin: 2.5em auto 0 0;
                transition: all 0.3s ease-in-out;
              }
              section a:hover,
              section a:focus {
                opacity: 1;
              }
              @media (max-width: 1020px) {
                section {
                  justify-content: center;
                }

                h1 {
                  padding-top: 2em;
                }
              }
            </style>
          </head>
          <body>
            <header>
              <div class="container">
                <a href="https://console.pipeops.io">
                  <img
                    src="https://res.cloudinary.com/djhh4kkml/image/upload/v1665733809/Pipeops/Pipeops_bcnyeo.png"
                    alt="pipeOps logo"
                  />
                </a>
              </div>
            </header>
            <main>
              <section>
                <div>
                  <h1>Page Not Found</h1>
                  <p>
                    Looks like the page you requested for doesn't exist. Let's get you back on track!
                  </p>
                  <a class="home-link" href="https://console.pipeops.io">Back to Home</a>
                </div>
                <div>
                  <img
                    src="https://pub-30c11acc143348fcae20835653c5514d.r2.dev//56/404_f3db939d90.svg"
                    alt="404 error"
                  />
                </div>
              </section>
            </main>
          </body>
        </html>

      502.html: |
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.cdnfonts.com/css/niveau-grotesk-regular" rel="stylesheet">
            <title>500 | Error on Deployment</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: 'Niveau Grotesk', sans-serif;
                }

                body {
                    background-color: #18181a;
                }

                img {
                    width: 160px;
                }

                .container {
                    max-width: 1200px;
                    width: 90%;
                    margin: 0 auto;
                }

                header {
                    padding: 1.5rem 0;
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                }

                main {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    height: 100vh;
                    text-align: center;
                }

                h1 {
                    font-family: 'Niveau Grotesk Bold', sans-serif;
                    font-size: clamp(5rem, 30vw, 10rem);
                    font-weight: 800;
                    color: #fff;
                    text-shadow: 2px 2px #655b86;
                }

                h2 {
                    font-family: 'Niveau Grotesk Bold', sans-serif;
                    color: #fff;
                    font-size: clamp(1.5rem, 5vw, 2.5rem);
                    margin-bottom: 1rem;
                }

                p {
                    color: #D8D8D899;
                    font-size: clamp(.8rem, 5vw, 1.5rem);
                    font-weight: 500;
                    max-width: 80%;
                    margin: 0 auto;
                }

                @media (max-width: 425px) {
                    img {
                        display: block;
                        margin: 0 auto;
                    }
                }
            </style>
        </head>
        <body>
        <header>
            <div class="container">
                <a href="https://pipeops.io">
                    <img src="https://res.cloudinary.com/djhh4kkml/image/upload/v1665733809/Pipeops/Pipeops_bcnyeo.png" alt="pipeOps logo">
                </a>
            </div>
        </header>
        <main>
            <div class="container">
                <h1>503</h1>
                <h2>Opps Error!!!</h2>
                <p>502 Bad Gateway. The server encountered a temporary error and could not complete your request. Please try again later.</p>
            </div>
        </main>
        </body>
        </html>
      503.html: |
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
              href="https://fonts.cdnfonts.com/css/niveau-grotesk-regular"
              rel="stylesheet"
            />
            <title>503 | Project Unavailable</title>
            <style>
              * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Niveau Grotesk", sans-serif;
              }

              body {
                background-color: #18181a;
              }

              img {
                width: 160px;
              }

              .container {
                max-width: 95%;
                margin: 0 auto;
              }

              header {
                padding: 2rem 0;
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
              }

              main {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                text-align: center;
              }

              section {
                display: flex;
                justify-content: space-between;
                gap: 3em;
                flex-wrap: wrap;
                align-items: center;
                max-width: 1300px;
                width: 90%;
                margin: 0 auto;
              }

              h1 {
                font-size: clamp(2.3rem, 6vw, 3rem);
                font-weight: 500;
                text-align: left;
                line-height: 111%;
                color: #fff;
                background: linear-gradient(
                    94deg,
                    rgba(255, 255, 255, 0.72) 42.56%,
                    rgba(255, 255, 255, 0.24) 63.66%,
                    rgba(255, 255, 255, 0.48) 83.86%
                  )
                  text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 0.3em;
              }

              p {
                color: rgba(255, 255, 255, 0.46);
                max-width: 562px;
                text-align: left;
                font-size: clamp(0.8rem, 5vw, 1.3rem);
                font-weight: 500;
                line-height: 150%;
              }

              section img {
                width: 30vw;
                min-width: 302px;
              }

              a {
                text-decoration: none;
                color: #d8d8d8;
                text-decoration: underline;
              }

              section a.home-link {
                border-width: 1px;
                border-style: solid;
                opacity: 0.7;
                border-radius: 4rem;
                color: #fff;
                padding: 1em 2em;
                text-decoration: none;
                border-image: linear-gradient(
                  90deg,
                  rgb(79, 33, 234) 0%,
                  rgb(190, 200, 255) 33%,
                  rgb(255, 213, 211) 66%,
                  rgb(255, 106, 106) 100%
                );
                background: linear-gradient(#0e0e0f, #0e0e0f) padding-box,
                  linear-gradient(
                      90deg,
                      rgb(79, 33, 234) 0%,
                      rgb(190, 200, 255) 33%,
                      rgb(255, 213, 211) 66%,
                      rgb(255, 106, 106) 100%
                    )
                    border-box;
                font-size: 1rem;
                display: block;
                width: fit-content;
                margin: 2.5em auto 0 0;
                transition: all 0.3s ease-in-out;
              }
              section a:hover,
              section a:focus {
                opacity: 1;
              }
              @media (max-width: 1020px) {
                section {
                  justify-content: center;
                }

                h1 {
                  padding-top: 2em;
                }
              }
            </style>
          </head>
          <body>
            <header>
              <div class="container">
                <a href="https://console.pipeops.io">
                  <img
                    src="https://res.cloudinary.com/djhh4kkml/image/upload/v1665733809/Pipeops/Pipeops_bcnyeo.png"
                    alt="pipeOps logo"
                  />
                </a>
              </div>
            </header>
            <main>
              <section>
                <div>
                  <h1>Project Unavailable</h1>
                  <p>
                    Oops! Your project is currently unavailable, possibly due to a
                    paused, expired subscription, and due to misconfiguration. Please
                    verify your server, check your subscription status, and review your
                    project settings. Visit our
                    <a target="_blank" href="https://docs.pipeops.io/docs/category/troubleshooting"
                      >troubleshooting page</a
                    >
                    for assistance.
                  </p>
                  <a class="home-link" href="https://console.pipeops.io"
                    >Back to Home</a
                  >
                </div>
                <div>
                  <img
                    src="https://pub-30c11acc143348fcae20835653c5514d.r2.dev//56/503_4ecd842aa2.svg"
                    alt="503 error"
                  />
                </div>
              </section>
            </main>
          </body>
        </html>
  YAML

  # depends_on = [ helm_release.application ]
}
