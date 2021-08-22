from flask import Blueprint
from mcstatus import MinecraftServer

stats_bp = Blueprint('stats', __name__)


@stats_bp.route('/main')
def main():
    '''Lookups main server and returns its stats'''
    server = MinecraftServer.lookup('play.fdl-mc.ru')
    query = server.query()
    status = server.status()
    latency = round(server.ping())

    res = {
        'online': True,
        'ip': server.host,
        'port': server.port,
        'description': status.description,
        'version': query.software.version,
        'latency': latency,
        'players': {
            'online': query.players.online,
            'max': query.players.max,
            'names': query.players.names,
        }
    }

    return res
