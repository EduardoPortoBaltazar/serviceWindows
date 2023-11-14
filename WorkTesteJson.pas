unit WorkTesteJson;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  system.json, Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    edtCaminho: TEdit;
    Button2: TButton;
    Memo1: TMemo;
    edtStartService: TEdit;
    lbv: TLabel;
    Label4: TLabel;
    edtStopService: TEdit;
    Button3: TButton;
    Button4: TButton;
    Timer: TTimer;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
  private
    function StartServiceBT(const ServiceName: string): Boolean;
    function StopService(const ServiceName: string): Boolean;
    procedure validarLog;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WinSvc, DateUtils;

{$R *.dfm}

procedure TForm1.Abrir1Click(Sender: TObject);
begin
  Self.Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ValidarLog;
end;


function TForm1.StopService(const ServiceName: string): Boolean;
var
  ServiceManager: SC_HANDLE;
  ServiceHandle: SC_HANDLE;
  ServiceStatus: TServiceStatus;
begin
  Result := False;
  ServiceManager := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if ServiceManager <> 0 then
  begin
    ServiceHandle := OpenService(ServiceManager, PChar(ServiceName), SERVICE_STOP or SERVICE_QUERY_STATUS);
    if ServiceHandle <> 0 then
    begin
      if ControlService(ServiceHandle, SERVICE_CONTROL_STOP, ServiceStatus) then
      begin
        Result := True;
      end;
      CloseServiceHandle(ServiceHandle);
    end;
    CloseServiceHandle(ServiceManager);
  end;
end;


procedure TForm1.TimerTimer(Sender: TObject);
begin
  Memo1.Lines.Add('******************************************************************************');
  Memo1.Lines.Add('Executando: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));
  Timer.Enabled := False;
  validarLog;
  Timer.Enabled := True;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  if WindowState = wsMinimized then
    WindowState := wsNormal
  else
    WindowState := wsMinimized;
end;

procedure TForm1.validarLog;
var
  busca: TSearchRec;
  resultadoBusca: Integer;
  LDataUltimoArquivo: TDateTime;
  LDifirencaEntreMinutos: Integer;
  CaminhoArquivo: string;
begin
  resultadoBusca := FindFirst(edtCaminho.Text + '\*.*', faAnyFile, busca);
  try
    if resultadoBusca = 0 then
    begin
      repeat
        if (busca.Attr and faDirectory) = 0 then
        begin
          caminhoArquivo := edtCaminho.Text + '\' + busca.Name;
          if FileAge(caminhoArquivo) > LDataUltimoArquivo then
            LDataUltimoArquivo := FileDateToDateTime(FileAge(caminhoArquivo));
        end;
        resultadoBusca := FindNext(busca);
      until resultadoBusca <> 0;
    end
    else
    begin
      Writeln('Erro ao procurar arquivos no diretório: ', edtCaminho.Text);
    end;

    LDifirencaEntreMinutos := MinutesBetween(Now, LDataUltimoArquivo);

    if LDifirencaEntreMinutos > 15  then
    begin
      Memo1.Lines.Add('Work não fez start automatico.' + FormatDateTime('HH:MM:SS', Now));
      Memo1.Lines.Add('Minutos sem processar:' + LDifirencaEntreMinutos.ToString);
      Memo1.Lines.Add(LDifirencaEntreMinutos.ToString);


      StopService(edtStopService.Text);
      Sleep(5000);
      StartServiceBT(edtStartService.Text);
      Sleep(5000);
    end;
  finally
    FindClose(busca);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  StartServiceBT(edtStartService.Text);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  StopService(edtStopService.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Hide;
end;

function TForm1.StartServiceBT(const ServiceName: string): Boolean;
var
  ServiceManager: SC_HANDLE;
  ServiceHandle: SC_HANDLE;
  Lvar: PChar;
begin
  Result := False;
  ServiceManager := OpenSCManager(nil, nil, SC_MANAGER_CONNECT);
  if ServiceManager <> 0 then
  begin
    ServiceHandle := OpenService(ServiceManager, PChar(ServiceName), SERVICE_START);
    if ServiceHandle <> 0 then
    begin
      Result := StartService(ServiceHandle, 0, Lvar);
      CloseServiceHandle(ServiceHandle);
    end;
    CloseServiceHandle(ServiceManager);
  end;
end;


end.
