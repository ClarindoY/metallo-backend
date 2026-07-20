"""Mostra o link de acesso (neste PC e na rede local)."""
import socket


def lan_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except Exception:
        try:
            return socket.gethostbyname(socket.gethostname())
        except Exception:
            return "127.0.0.1"


if __name__ == "__main__":
    ip = lan_ip()
    print("=" * 56)
    print("  GERADOR DE PECAS METALLO")
    print("-" * 56)
    print("  Neste PC:        http://localhost:8501")
    print(f"  Na rede local:   http://{ip}:8501")
    print("  (compartilhe o link 'na rede local' com a equipe)")
    print("=" * 56)
