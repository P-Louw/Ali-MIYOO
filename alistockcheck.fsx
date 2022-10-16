#!/usr/bin/env -S dotnet fsi

#r "nuget: FSharp.Data, 4.2.5"

open System.Net.Mail
open FSharp.Data
open System.Net
open System

(*
    Check if a div with the no result id is found where items should be listed.
    If found no stock else there is stock so send a email.
*)

[<Literal>]
let mailbody = """
            🕹 MIYOO STOCK REFILLED 🎉
            Go to site: 
                https://nl.aliexpress.com/store/912663639?spm=a2g0o.store_pc_allProduct.pcShopHead_6001952523151.0
"""

let recipient = Environment.GetEnvironmentVariable("recipient")

module SmtpSender =
    type smtp = {
        mail: string
        server: string
        port: int
        password: string
    }

    let initfromEnv () =
        let sender = 
            {
                mail = Environment.GetEnvironmentVariable("mail")
                server = Environment.GetEnvironmentVariable("server") 
                port = Environment.GetEnvironmentVariable("port") |> int 
                password = Environment.GetEnvironmentVariable("password") 
            }
        sender
    
/// Send email to notify about stock:
let mailExecute (smtpCred:SmtpSender.smtp) (sub:string, body:string) (receiver:string) =
    use msg = 
        new MailMessage(
            smtpCred.mail, receiver, sub, 
            body)
            
    use client = new SmtpClient(smtpCred.server)
    client.Port <- smtpCred.port
    client.Credentials <- new NetworkCredential(smtpCred.mail, smtpCred.password);
    client.DeliveryMethod <- SmtpDeliveryMethod.Network
    client.EnableSsl <- true
    client.UseDefaultCredentials <- false
    
    client.Send msg

/// Check if we get the 'Sorry no stock page':
let checkStock () =
    let storeDoc = HtmlDocument.Load("https://miyoo.nl.aliexpress.com/store/group/Handheld-Game-Console/912663639_10000003620340.html?spm=a2g0o.store_pc_home.pcShopHead_6001952523151.1_0")

    let digEx = 
        storeDoc.CssSelect("body > div#page > div#content > div#bd > div#bd-inner > div.layout > div.col-main > div.main-wrap > div#node-gallery > div.board > span.m > div.no-result-title") 
    printfn "Checking stock"
    if (digEx.Length) > 0 
    then 
        printfn "No items in stock"
        None
    else
        printfn "Products in stock!"
        Some "MIYOO STOCK"

let smtpSession = SmtpSender.initfromEnv()
let sendMail = mailExecute smtpSession

match fsi.CommandLineArgs with
| [|_;"testmail"|] -> 
    printfn "Sending test email."
    sendMail ("Test mail", "Notifier is able to send mail.") smtpSession.mail
| _ ->
    checkStock ()
    |> function
        | Some _ -> 
            sendMail ("MIYOO STOCK", mailbody) recipient
        | _ -> ()